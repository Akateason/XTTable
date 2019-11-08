Pod::Spec.new do |s|
  s.name             = 'XTTable'
  s.version          = '0.0.1'
  s.summary          = 'Fast way to setup TableView and CollectionView .'
  #s.description      =
  s.homepage         = 'https://github.com/akateason/XTTable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'teason' => 'akateason@qq.com' }
  s.source           = { :git => 'https://github.com/akateason/XTTable.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TableDatasourceSeparation/XTTable/*.{h,m}','TableDatasourceSeparation/XTCollection/*.{h,m}'
  s.public_header_files = "TableDatasourceSeparation/XTTable/*.h","TableDatasourceSeparation/XTCollection/*.h"
  
  s.dependency 'XTBase'
  
end
