
require File.expand_path('spec/helper')
require 'Datag'
require 'Bacon_Colored'
require 'pry'
require 'pty'

TMP = "/tmp/Datag"
Me_List = %w{ 
  v1.1.1 
  v1.2.1 
  v1.11.0 
  v2.0.0 
  v2.0.1 
  v2.0.02 
}

class Test_Datag
  include Datag::DSL
end

def chdir str = ''
  Dir.chdir(File.join TMP, str) { yield }
end

def reset_tmp
  
  Exit_0 "
    rm -rf #{TMP}
    mkdir -p #{TMP}
  "
  chdir {
    Exit_0 %^
      mkdir Me
      cd Me
      git init
      touch Readme.md
      git add .
      git commit -m "First commit."
      git tag First_Commit

      cd ..
      mkdir Zerrol
      cd Zerrol
      git init 
    ^
  }

  Me_List.each_with_index { |v, i|
    chdir('Me') { 
      Exit_0 %^
      touch #{v}.md
      git add .
      git commit -m "#{i} commit: #{v}"
      git tag #{v}
      ^
    }
  }

end # === def reset_tmp

# ======== Include the tests.
if ARGV.size > 1 && ARGV[1, ARGV.size - 1].detect { |a| File.exists?(a) }
  # Do nothing. Bacon grabs the file.
else
  Dir.glob('spec/tests/*.rb').each { |file|
    require File.expand_path(file.sub('.rb', '')) if File.file?(file)
  }
end
