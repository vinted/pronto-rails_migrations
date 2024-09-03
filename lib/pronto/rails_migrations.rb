module Pronto
  class RailsMigrations < Runner
    def run
      return [] unless migration_patches?

      messages = []

      if other_patches?
        patch = migration_patches.first
        messages << message(
          patch,
          'Run migrations in a separate PR from application code changes.',
          level: :error
        )
      end

      messages + bad_structure_sql_messages
    end

    private

    def migration_patches?
      migration_patches.any?
    end

    def migration_patches
      @migration_patches ||= @patches.select { |patch| migration_patch?(patch) }
    end

    def other_patches?
      @patches.reject { |patch| migration_patch?(patch) }.any?
    end

    def bad_structure_sql_messages
      patch = structure_sql_patches.first
      return [] unless patch

      structure_sql = File.read(patch.new_file_full_path)
      inserts = structure_sql.split("\n").grep(/\('\d+'\)/)
      unordered_inserts = (inserts.sort.reverse != inserts)

      *all_but_tail, tail = inserts
      bad_semicolons = all_but_tail.any? { |line| line.end_with?(';') } || !tail.end_with?(';')

      bad_ending = structure_sql[-2, 2] !~ /[^\n]\n/

      messages = []

      if unordered_inserts
        messages << message(
          patch,
          '`schema_migrations` insert values are not ordered by timestamp.'
        )
      end
      if bad_semicolons
        messages << message(
          patch,
          '`schema_migrations` inserts must end with comma (`,`), ' \
          'last insert must end with semicolon (`;`).'
        )
      end
      messages << message(patch, '`db/structure.sql` must end without extra empty lines.') if bad_ending

      messages
    end

    def message(patch, text, level: :error)
      path = patch.delta.new_file[:path]
      line = patch.added_lines.last
      Message.new(path, line, level, text, nil, self.class)
    end

    def structure_sql_patches
      @patches.select { |patch| patch.new_file_full_path.to_s =~ /structure\.sql/ }
    end

    def migration_patch?(patch)
      path = patch.new_file_full_path.to_s
      /db.(schema.rb|structure.sql|migrate)/ =~ path
    end
  end
end
