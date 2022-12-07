import sys
import hashlib
import hmac
import base64

# args
token = sys.argv[1]
secret = sys.argv[2]
nonce = sys.argv[3]
t = sys.argv[4]

# generate sha256
string_to_sign = bytes('{}{}{}'.format(token, t, nonce), 'utf-8')
secret = bytes(secret, 'utf-8')
sign = base64.b64encode(hmac.new(secret, msg=string_to_sign, digestmod=hashlib.sha256).digest())

# result
print('{}'.format(str(sign, 'utf-8')))
