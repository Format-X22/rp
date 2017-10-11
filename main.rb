require 'sinatra'
require 'recursive-open-struct'

$locale = {}

Dir['./locale/*'].each do |path|
	name = path.split('/').last.split('.').first
	hash = JSON.parse(File.read(path))

	$locale[name] = RecursiveOpenStruct.new(hash)
end

get '/' do
	redirect '/en'
end

get '/:lang' do
	locale = $locale[params['lang']] or $locale['en']

	erb(File.read('views/main.html'), locals: {l: locale})
end