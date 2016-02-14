module Repositories
  class Inqlude < Base
    HAS_VERSIONS = false
    HAS_DEPENDENCIES = false
    LIBRARIAN_SUPPORT = false
    URL = 'https://inqlude.org/'
    COLOR = '#f34b7d'

    def self.project_names
      @project_names ||= `rm -rf inqlude-data;git clone https://github.com/cornelius/inqlude-data.git --depth 1; ls -l inqlude-data/ | grep "^d" | awk -F" " '{print $9}'`.split("\n")
    end

    def self.project(name)
      versions = `ls inqlude-data/#{name}`.split("\n").sort
      version = versions.last
      json = Oj.load `cat inqlude-data/#{name}/#{version}`
    end

    def self.mapping(project)
      {
        :name => project['name'],
        :description => project["summary"],
        :homepage => project["urls"]["homepage"],
        :licenses => project['licenses'].join(','),
        :repository_url => repo_fallback(project["urls"]["vcs"], '')
      }
    end
  end
end
