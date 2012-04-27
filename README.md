
Datag: da99's git tagger as a Ruby gem
================

A Ruby gem to print previous/next git tags: v1.0, v2.1.0, etc.

Installation
------------

    gem install Datag

Usage: Ruby
------

    require "Datag"
    
    Datag.list     => [ "v1.0.0", "v1.2.4", "v1.11.0", "v2.0.0", "v9.0.0" ]
    
    system "git checkout v2.0.0"
    
    Datag.next     => "v9.0.0"
    Datag.previous => "v1.11.0"

    Datag.bump_patch => "v9.0.1"
    Datag.bump_minor => "v9.1.0"
    Datag.bump_major => "v10.0.0"

Usage: Shell
-----

    Datag list       
    Datag list -r   # Reverse the order.
    
    Datag first     # oldest: v1.0.0
    Datag last      # newest: v9.0.0

    Datag next
    Datag previous
    
    git checkout $( Datag next )
    
    git tag $( Datag bump_patch )
    git tag $( Datag bump_minor )
    git tag $( Datag bump_major )

Run Tests
---------

    git clone git@github.com:da99/Datag.git
    cd Datag
    bundle update
    bundle exec bacon spec/main.rb

"I hate writing."
-----------------------------

If you know of existing software that makes the above redundant,
please tell me. The last thing I want to do is maintain code.

