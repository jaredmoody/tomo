module Jam::Plugins::Core
  class Tasks < Jam::TaskLibrary
    def create_shared_directories
      return if linked_dirs.empty?

      remote.mkdir_p(paths.shared)

      remote.chdir(paths.shared) do
        remote.mkdir_p(*linked_dirs)
      end
    end

    def symlink_shared_directories
      return if linked_dirs.empty?

      create_linked_parents
      linked_dirs.each do |dir|
        remote.ln_sf paths.shared.join(dir), paths.release.join(dir)
      end
    end

    def symlink_current
      remote.ln_sfn paths.release, paths.current
    end

    # rubocop:disable Metrics/AbcSize
    def clean_releases
      desired_count = settings[:keep_releases].to_i
      return if desired_count < 1

      remote.chdir(paths.releases) do
        releases = remote.list_files.grep(/^\d{14}$/).sort
        return if releases.length <= desired_count

        remote.rm_rf(*releases.take(releases.length - desired_count))
      end
    end
    # rubocop:enable Metrics/AbcSize

    private

    def linked_dirs
      settings[:linked_dirs]
    end

    def create_linked_parents
      parents = linked_dirs.map do |dir|
        paths.release.join(dir).dirname
      end
      parents = parents.uniq - [paths.release]

      remote.mkdir_p(*parents) unless parents.empty?
    end
  end
end