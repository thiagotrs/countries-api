not_found do
    if request.content_type == nil
        content_type 'text/html'
        erb :not_found
    else
        content_type 'application/json'
        json 'error' => 'Resource is not found.'
    end
end

before do
    content_type :json
end

helpers do
    def getCountries
        countries = ""
        file = File.open(File.join(settings.public_folder, 'countries.json'))
        file.each do |line|
            countries = countries + line
        end
        JSON.parse(countries)
    end
end

get '/' do
    # @title = 'Countries API'
    content_type :html
    erb :index
end

get '/api/?*' do
    redirect to('/')
end

get '/countries' do
    send_file File.join(settings.public_folder, 'countries.json')
end

get '/countries/name/:name' do
    countries = getCountries()
    result = countries.select { |c| c['name']['common'] == params[:name] || c['name']['official'] == params[:name] || c['name']['native']['common'] == params[:name] || c['name']['native']['official'] == params[:name] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/code/:code' do
    countries = getCountries()
    result = countries.select { |c| c['cca2'] == params[:code] || c['cca3'] == params[:code] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/capital/:capital' do
    countries = getCountries()
    result = countries.select { |c| c['capital'] == params[:capital] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/callingcode/:callingcode' do
    countries = getCountries()
    result = countries.select { |c| c['callingCode'].include? params[:callingcode] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/currencycode/:currency' do
    countries = getCountries()
    result = countries.select { |c| c['currency'].include? params[:currency] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/language/:language' do
    countries = getCountries()
    result = countries.select { |c| c['languages'].has_key? params[:language] || c['languages'].has_value? params[:language] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/region/:region' do
    countries = getCountries()
    result = countries.select { |c| c['region'] == params[:region] }
    (result.empty?) ? (status 404) : result.to_json
end

get '/countries/subregion/:subregion' do
    countries = getCountries()
    result = countries.select { |c| c['subregion'] == params[:subregion] }
    (result.empty?) ? (status 404) : result.to_json
end