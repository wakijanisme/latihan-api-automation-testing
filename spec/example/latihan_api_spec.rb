describe 'latihan api https://restful-api.dev/' do

  it 'get LIST OF ALL OBJECTS', :test_1, :get do
    get '/objects'

    #ap json_body #biar output nya bagus

    expect_status(200) #ngecek validasi untuk http statusnya
    expect_json_types('*', id: :string, name: :string) #ngecek validasi untuk jenis type value
    expect_json_types('*', data: :object_or_null) #ngecek validasi untuk value data isinya object atau null
  end

  it 'get LIST OF OBJECTS BY IDS', :test_2, :get do
    get '/objects', 'params' =>
    {
      'id' => '4, 5'
    }

    expect_status(200) # assertion
    #satuan
    expect_json_types('0', id: :string, name: :string) # assertion
    expect_json_types('0', data: :object_or_null) # assertion

    expect_json_types('1', id: :string, name: :string) # assertion
    expect_json_types('1', data: :object_or_null) # assertion

    #atau bulk
    #expect_json_types('*', id: :string, name: :string) # assertion
    #expect_json_types('*', data: :object_or_null) # assertion

  end

  it 'get SINGLE OBJECT', :test_3, :get do

    object_id = 7
    get "/objects/#{object_id}"

    expect_status(200) # assertion
    expect_json_types(id: :string, name: :string) # assertion
    expect_json_types(data: :object_or_null) # assertion

    expect_json(id: '7')
    expect_json(name: 'Apple MacBook Pro 16')
    expect_json(data:{
      year: 2019,
      "CPU model": "Intel Core i9",
    })

  end

  it 'post ADD OBJECT', :test_4 do

    #request body
    post '/objects', {
      "name": "Vivo HP Lama Banget",
      "data": {
        "year": 2001,
        "price": 189.99,
        "CPU model": "Intel Pentium 4",
        "Hard disk size": "50 MB",
        "Color": "Black"
        }
    }

    ap json_body

    expect_json_types(id: :string)

      #cara 1
    #expect_json("name": "Vivo HP Lama Banget")
    #expect_json("data.year": 2001)
    #expect_json("data.price": 189.99)
    #expect_json("data.Color": "Black")

      #cara 2
      expect_json("name": "Vivo HP Lama Banget")
      expect_json("data":{
        "year": 2001,
        "price": 189.99,
        "Color": "Black"
      })

  end

  it 'put UPDATE OBJECT', :test_5 do

    object_id = 'ff8081819027333501904034f8f928d7'
    #request body
    put "/objects/#{object_id}", {
    "name": "Vivo HP Lama Banget Tahun 2000",
      "data": {
        "year": 2000,
        "price": 100.99,
        "CPU model": "Intel Pentium 4",
        "Hard disk size": "50 MB",
        "Color": "Black"
      }
    }

    ap json_body

    expect_json_types(id: :string)

    expect_json("name": "Vivo HP Lama Banget Tahun 2000")
    expect_json("data":{
      "year": 2000,
      "price": 100.99,
      "CPU model": "Intel Pentium 4",
      "Hard disk size": "50 MB",
      "Color": "Black"
    })

  end

  it 'patch PARTIALLY UPDATE OBJECT', :test_6 do

    object_id = 'ff8081819027333501904034f8f928d7'
    #request body
    patch "/objects/#{object_id}", {
    "name": "Vivo HP Lama Banget 2000 (updated name)",
    #"data": {
    #    "CPU model": "Dual Core (updated)",
    #    "Hard disk size": "100 MB (updated)",
    #  }
    }

    ap json_body

    expect_json_types(id: :string)

    expect_json("name": "Vivo HP Lama Banget 2000 (updated name)")
    #expect_json("data":{
    #  "year": 2000,
    #  "price": 100.99,
    #  "CPU model": "Dual Core (updated)",
    # "Hard disk size": "100 MB (updated)",
    #  "Color": "Black"
    #})

  end

  it 'delete DELETE OBJECT', :test_7 do

    object_id = 'ff8081819027333501904034f8f928d7'
    delete "/objects/#{object_id}"

    expect_status(200)

    expect_json(message: "Object with id = #{object_id} has been deleted.")

  end

end
