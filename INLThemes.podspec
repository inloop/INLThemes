
Pod::Spec.new do |spec|
	spec.name         = 'INLThemes'
	spec.version      = '1.0.0'
	spec.platform     = :ios, '8.0'
	spec.license      = { :type => 'MIT' }
	spec.homepage     = 'https://github.com/inloop/INLThemes'
	spec.authors      = { 'Tomas Hakel' => 'tomas.hakel@inloop.eu' }
	spec.summary      = 'An iOS library for supporting multiple UI themes'
	spec.source       =  { :git => 'https://github.com/inloop/INLThemes.git', :tag => spec.version }
	spec.source_files = 'INLThemes/**/*.{h,m,swift}'
end