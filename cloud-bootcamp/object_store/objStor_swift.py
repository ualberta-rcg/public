import swiftclient
user = 'username:swift'
key = 'XXXXXXXXXXXXXXXXXXXXXX' # replace it with your own swift access key

# Get connected with the above key
conn = swiftclient.Connection(
        user=user,
        key=key,
        authurl='https://object-arbutus.cloud.computecanada.ca/auth',
)

# Create a container
container_name = 'bootcamp2'
conn.put_container(container_name)

# Create an object with the content read from a local file
with open('hello.txt', 'r') as hello_file:
        conn.put_object(container_name, 'hello.txt',
                        contents= hello_file.read(),
                        content_type='text/plain')

# List all containers
for container in conn.get_account()[1]:
        print(container['name'])

# Display the content in a container
for data in conn.get_container(container_name)[1]:
        print('{0}\t{1}\t{2}'.format(data['name'], data['bytes'], data['last_mo$

# Download an object
obj_tuple = conn.get_object(container_name, 'hello.txt')
print(str(obj_tuple[-1]))
with open('hello2_downloaded.txt', 'w') as objHello:
        objHello.write(str(obj_tuple))

# Delete a container
conn.delete_object(container_name, 'hello.txt')
