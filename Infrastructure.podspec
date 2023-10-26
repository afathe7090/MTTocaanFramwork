
Pod::Spec.new do |spec|

  spec.name         = "Infrastructure"
  spec.version      = "1.0.0"
  spec.summary      = "Infrastructure is network manager allow to request with multipart"
  spec.description  = "Infrastructure is network manager allow to request with multipart and support combine frameworks"
  spec.homepage     = "https://github.com/afathe7090/MTTocaanFramwork"
  spec.license      = "MIT"
  spec.author             = { "Ahmed Fathy" => "afathe7090" }
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/afathe7090/MTTocaanFramwork.git", :tag => spec.version.to_s }
  spec.source_files  = "Infrastructure/**/*"
  spec.swift_versions = "5.9"
end
