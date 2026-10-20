const https = require('https');
const crypto = require('crypto');
const fs = require('fs');

const keyId = '9N9MLJ4ZMT';
const issuerId = 'caf1dcf5-8ca9-4976-a1ab-be3cad94f979';
const p8Path = 'C:\\Users\\zanay\\Downloads\\AuthKey_9N9MLJ4ZMT.p8';
const privateKey = fs.readFileSync(p8Path, 'utf8');

function createJwt() {
  const header = { alg: 'ES256', kid: keyId, typ: 'JWT' };
  const now = Math.floor(Date.now() / 1000);
  const payload = {
    iss: issuerId,
    exp: now + 20 * 60,
    aud: 'appstoreconnect-v1'
  };

  const b64Header = Buffer.from(JSON.stringify(header)).toString('base64url');
  const b64Payload = Buffer.from(JSON.stringify(payload)).toString('base64url');
  const data = `${b64Header}.${b64Payload}`;

  const signer = crypto.createSign('SHA256');
  signer.update(data);
  const sig = signer.sign({ key: privateKey, dsaEncoding: 'ieee-p1363' }, 'base64url');
  return `${data}.${sig}`;
}

const token = createJwt();

function apiRequest(path, method = 'GET') {
  return new Promise((resolve, reject) => {
    const req = https.request({
      hostname: 'api.appstoreconnect.apple.com',
      path: path,
      method: method,
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    }, res => {
      let body = '';
      res.on('data', chunk => body += chunk);
      res.on('end', () => resolve({ status: res.statusCode, data: body }));
    });
    req.on('error', reject);
    req.end();
  });
}

async function main() {
  const res = await apiRequest('/v1/certificates?filter[certificateType]=DISTRIBUTION,IOS_DISTRIBUTION');
  console.log(`Status: ${res.status}`);
  const json = JSON.parse(res.data);
  if (json.data) {
    console.log(`Found ${json.data.length} distribution certificates:`);
    json.data.forEach(c => {
      console.log(`ID: ${c.id} | Name: ${c.attributes.name} | Expiration: ${c.attributes.expirationDate}`);
    });
  } else {
    console.log(res.data);
  }
}

main().catch(console.error);
