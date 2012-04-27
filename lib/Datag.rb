require 'Datag/version'
require 'Exit_Zero'
require 'Split_Lines'

class Datag
  
  module DSL
    
    def list
      Split_Lines(Exit_0("git tag -l").out)
      .select { |str|
        str[ %r!v[\d\.]! ]
      }
      .sort_by { |str| 
        to_arr str
      }
    end

    def next
      move 1
    end
    
    def previous
      move -1
    end

    def first
      list.first
    end

    def last
      list.last
    end

    def move count
      c = current
      l = list
      i = list.index(c.split('-').first)
      return c if i.nil? || (i == 0 && count < 0)
      t = l[ i + count ]
      return c if t.nil?
      t
    end

    def current
      Exit_0('git describe --tag').out
    end

    def bump_patch
      mj, m, p = to_arr( last! )
      to_str  mj, m, p + 1
    end
    
    def bump_minor
      mj, m, p = to_arr( last! )
      to_str  mj, m + 1, 0
    end

    def bump_major
      mj, m, p = to_arr( last! )
      to_str mj + 1, 0, 0
    end

    def to_arr str
      mj, m, p = str.sub('v', '').split( '.' ).map(&:to_i)
      [ (mj || 0), (m || 0), (p || 0) ]
    end

    def to_str *arr
      "v" + arr.flatten.join('.')
    end

    def last!
      list.last || "v0.0.0"
    end

  end # === DSL
  
  extend DSL

end # === class Datag
