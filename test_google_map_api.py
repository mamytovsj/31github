import requests

base_url = 'https://rahulshettyacademy.com'
key = '?key=qaclick123'
place_id = None
new_address = '100, Isanova street'


def test_create_location():
    '''Создание новой локации'''
    resource = '/maps/api/place/add/json'

    url = base_url + resource + key
    print('\nURL: ' + url)

    json_body_to_create_new_location = {
        "location": {
            "lat": -38.383494,
            "lng": 33.427362
        },
        "accuracy": 50,
        "name": "Petty Friend",
        "phone_number": "(+996) 777 98 11 89",
        "address": "103, Toktogula street",
        "types": [
            "pets’ shop",
            "shop"
        ],
        "website": "http://google.com",
        "language": "English-EN"
    }
    response = requests.post(url, json=json_body_to_create_new_location)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')

    assert 200 == response.status_code
    print('------> Статус код верный!')

    json_body = response.json()
    field_status = json_body.get('status')
    print(f'Поле статус в ответе: {field_status}')
    global place_id
    place_id = json_body.get('place_id')
    print(f'Поле place_id в ответе: {place_id}')
    print(f'Создание новой локации === УСПЕШНО!')


def test_get_created_location():
    '''Проверка создания новой локации'''

    resourse = '/maps/api/place/get/json'
    url = base_url + resourse + key + '&place_id=' + place_id
    print('\nURL: ' + url)
    response = requests.get(url)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')

    assert 200 == response.status_code
    print('------> Статус код верный!')
    print(f'Проверка создания новой локации === УСПЕШНО!')


def test_update_location_address():
    '''Изменение адреса локации'''
    resource = '/maps/api/place/update/json'

    url = base_url + resource + key
    print('\nURL: ' + url)

    json_body_to_update_address = {
        "place_id": place_id,
        "address": new_address,
        "key": "qaclick123"
    }
    response = requests.put(url, json=json_body_to_update_address)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')
    assert 200 == response.status_code
    print('------> Статус код верный!')

    json_body = response.json()
    field_msg = json_body.get('msg')
    print(f'Поле msg в ответе: {field_msg}')
    assert field_msg == 'Address successfully updated'
    print('------> Сообщение верное!')
    print(f'Изменение адреса локации === УСПЕШНО!')


def test_get_updated_location():
    '''Проверка изменения статуса в новой локации'''
    resourse = '/maps/api/place/get/json'
    url = base_url + resourse + key + '&place_id=' + place_id
    print('\nURL: ' + url)
    response = requests.get(url)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')

    assert 200 == response.status_code
    print('------> Статус код верный!')

    json_body = response.json()
    field_address = json_body.get('address')
    print(f'Поле address в ответе: {field_address}')
    assert field_address == new_address
    print('------> Адрес верный!')
    print(f'Проверка изменения статуса в новой локации === УСПЕШНО!')


def test_delete_location():
    '''Удаление локации'''
    resourse = '/maps/api/place/delete/json'
    url = base_url + resourse + key
    print('\nURL: ' + url)

    json_body_to_delete = {
        "place_id": place_id
    }

    response = requests.delete(url, json=json_body_to_delete)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')

    assert 200 == response.status_code
    print('------> Статус код верный!')
    json_body = response.json()
    field_status = json_body.get('status')
    print(f'Поле статус в ответе: {field_status}')
    assert field_status == 'OK'
    print('------> Статус в теле верный!')
    print(f'Удаление локации === УСПЕШНО!')

def test_get_deleted_location():
    '''Проверка удаления новой локации'''

    resourse = '/maps/api/place/get/json'
    url = base_url + resourse + key + '&place_id=' + place_id
    print('\nURL: ' + url)
    response = requests.get(url)
    print(response.text)
    print(f'Статус код ответа: {response.status_code}')

    assert 404 == response.status_code
    print('------> Статус код верный!')

    json_body = response.json()
    field_msg = json_body.get('msg')
    print(f'Поле msg в ответе: {field_msg}')
    assert field_msg == "Get operation failed, looks like place_id  doesn't exists"
    print('------> Сообщение верное!')
    print(f'Проверка удаления новой локации === УСПЕШНО!')