const https = require('https');
const crypto = require('crypto');
const fs = require('fs');
const { execSync } = require('child_process');

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

async function run() {
  // 1. Fetch current distribution certificates
  console.log('Fetching certificates...');
  const res = await apiRequest('/v1/certificates?filter[certificateType]=DISTRIBUTION,IOS_DISTRIBUTION');
  const json = JSON.parse(res.data);
  if (json.data && json.data.length > 0) {
    for (const cert of json.data) {
      console.log(`Deleting orphan certificate: ${cert.id} (${cert.attributes.name})...`);
      const delRes = await apiRequest(`/v1/certificates/${cert.id}`, 'DELETE');
      console.log(`Delete ${cert.id} status: ${delRes.status}`);
    }
  }

  // 2. Generate a permanent RSA 2048 private key
  console.log('Generating permanent RSA 2048 private key...');
  const { privateKey: rsaKey } = crypto.generateKeyPairSync('rsa', {
    modulusLength: 2048,
    publicKeyEncoding: { type: 'spki', format: 'pem' },
    privateKeyEncoding: { type: 'pkcs8', format: 'pem' }
  });

  const certKeyPath = 'C:\\Users\\zanay\\Downloads\\certificate_private_key.pem';
  fs.writeFileSync(certKeyPath, rsaKey);
  console.log(`Saved permanent key to: ${certKeyPath}`);

  // 3. Set into GitHub Secrets
  console.log('Setting CERTIFICATE_PRIVATE_KEY secret in GitHub...');
  execSync(`gh secret set CERTIFICATE_PRIVATE_KEY -R zanyaris1/nada-zikr < "${certKeyPath}"`, { shell: 'cmd.exe', stdio: 'inherit' });
  console.log('Done!');
}

run().catch(console.error);
