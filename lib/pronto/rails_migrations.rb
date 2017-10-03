module Pronto
  class RailsMigrations < Runner
    def run
      if migration_patches? && other_patches?
        migration_patches.take(1).map do |patch|
          Message.new(
            patch.delta.new_file[:path],
            nil,
            :warning,
            "Run migrations in a separate PR from application code changes.",
            nil,
            self.class
          )
        end
      else
        []
      end
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

    def migration_patch?(patch)
      path = patch.new_file_full_path.to_s
      /db.(schema.rb|structure.sql|migrate)/ =~ path
    end
  end
end
