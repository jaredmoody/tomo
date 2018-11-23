module Jam
  autoload :CLI, "jam/cli"
  autoload :Colors, "jam/colors"
  autoload :Commands, "jam/commands"
  autoload :Error, "jam/error"
  autoload :Framework, "jam/framework"
  autoload :Logger, "jam/logger"
  autoload :Path, "jam/path"
  autoload :Paths, "jam/paths"
  autoload :Plugin, "jam/plugin"
  autoload :Plugins, "jam/plugins"
  autoload :Remote, "jam/remote"
  autoload :RemoteExecutionError, "jam/errors/remote_execution_error"
  autoload :Result, "jam/result"
  autoload :Script, "jam/script"
  autoload :ShellBuilder, "jam/shell_builder"
  autoload :SSH, "jam/ssh"
  autoload :TaskLibrary, "jam/task_library"
  autoload :VERSION, "jam/version"

  def self.load!(environment: nil, settings: {})
    Framework.new.load!(environment: environment, settings: settings)
  end
end
