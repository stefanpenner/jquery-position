directory 'output'

file 'jquery-position.js' => 'output' do
  sh 'coffee --bare -o output -c lib/jquery-position.coffee'
end

task 'clean' do
  rm_rf 'output/*'
end

task :default => 'jquery-position.js'
