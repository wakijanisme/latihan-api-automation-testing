describe 'latihan api https://restful-api.dev/' do

  it 'get LIST OF ALL OBJECTS', :test_1 do
    get '/objects'

    ap json_body #biar output nya bagus

    expect_status(200) #ngecek validasi untuk http statusnya
    expect_json_types('*', id: :string, name: :string) #ngecek validasi untuk jenis type value
    expect_json_types('*', data: :object_or_null) #ngecek validasi untuk value data isinya object atau null
  end

end
