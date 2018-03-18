

Pod::Spec.new do |s|
          #1.
          s.name               = "TACCircularProgress"
          #2.
          s.version            = "0.0.1"
          #3.  
          s.summary         = "TACCircular Progress is use to show circular progressbar"
          #4.
          s.homepage        = "http://www.tacme.com"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Nilesh"
          #7.
          s.platform            = :ios, "10.0"
	  s.swift_version = "4.0"
          #8.
          s.source              = { :git => "https://github.com/NSadava/TACCircularProgress.git", :tag => "0.0.1" }
          #9.
          s.source_files     = "TACCircularProgress", "TACCircularProgress/**/*.{h,m,swift}"
    end