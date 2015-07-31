module TravisBuildTools
  module DSL
    def publish_git_tag(*args, &block)
      PublishGitTagTask.define_task(*args, &block)
    end
  end

  class PublishGitTagTask < Rake::Task
    attr_accessor :service_user
    attr_accessor :tag_name
    attr_accessor :git_repository

    def initialize(task_name, app)
	  super(task_name, app)
	end

    def execute(args=nil)
      super(args)

      if ENV['TRAVIS'] && ENV['TRAVIS_PULL_REQUEST'].match(/false/i)
        raise 'service_user is not specified' if !@service_user
        raise 'tag_name is not specified' if !@tag_name
        raise 'git_repository is not specified' if !@git_repository

        #Setup up deploy
        puts %x[git config --global user.email "builds@travis-ci.com"]
        puts %x[git config --global user.name "Travis CI"]
        puts %x[git tag #{tag_name} -a -m "Generated tag from TravisCI."]
        puts "Pushing Git tag #{tag_name}."

        %x[git push --tags --quiet https://#{service_user}@#{git_repository} #{tag_name} > /dev/null 2>&1]
      end
    end
  end
end
