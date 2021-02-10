import boto
import boto.s3.connection

#access_key="xxxxxxxxxxxxxxxxxxxxx"
#secret_key="yyyyyyyyyyyyyyyyyyyyy"


#Get connected to the object storage server with the above keys
conn = boto.connect_s3(
        aws_access_key_id = access_key,
        aws_secret_access_key = secret_key,
        host = 'object-arbutus.cloud.computecanada.ca',
        #is_secure=False,               # uncomment if you are not using ssl
        calling_format = boto.s3.connection.OrdinaryCallingFormat(),
        )

# Print all the buckets
for bucket in conn.get_all_buckets():
    print "{name}\t{created}".format(
    name = bucket.name,
    created = bucket.creation_date,
)
print "\n"


# Create a new bucket
print "create a new bucket:\n"
bucket = conn.create_bucket('bootcamp-0210-new')

# Add contents to the new bucket
key = bucket.new_key('helloWorld') # name the object #1
key.set_contents_from_string('Hello World!') # content from a string (or can be from a file using .set_contents_from_filename()). 
key = bucket.new_key('aSecret') # name object #2
key.set_contents_from_string('This is a secret!') # content of object #2

# Display the meta-data of all the contents
for key in bucket.list():
    print key.name
    print "{name}\t{size}\t{modified}".format(
    name = key.name,
    size = key.size,
    modified = key.last_modified,
    )

# Set ACLs
hello_key = bucket.get_key('helloWorld')
hello_key.set_canned_acl('public-read')
plans_key = bucket.get_key('aSecret')
plans_key.set_canned_acl('private')

# Generate URLs 
hello_key = bucket.get_key('helloWorld')
hello_url = hello_key.generate_url(0, query_auth=False, force_http=True)
print hello_url

plans_key = bucket.get_key('aSecret')
plans_url = plans_key.generate_url(3600, query_auth=True, force_http=True)
print plans_url
