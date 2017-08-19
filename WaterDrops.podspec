Pod::Spec.new do |s|
  s.name             = 'WaterDrops'
  s.version          = '0.1.1'
  s.summary          = 'Simple water drops animation 💧'
  s.description      = <<-DESC
                      Simple water drops background animation
                      DESC
  s.homepage         = 'https://github.com/LeFal/WaterDrops'
  #s.screenshots      = '[IMAGE URL 1]', '[IMAGE URL 2]'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LeFal' => 'qwertyhj2@gmail.com' }
  s.source           = { :git => 'https://github.com/LeFal/WaterDrops.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/*.swift'
end
