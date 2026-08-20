// Checks every actionUrl in projects_data.js plus the links in index.html.
// Six dead /personal-projects/ URLs shipped unnoticed because nothing did this.
// Run: node scripts/check-links.mjs
import { readFileSync } from 'node:fs';

const root = new URL('..', import.meta.url);
const read = (p) => readFileSync(new URL(p, root), 'utf8');

const data = new Function(`${read('projects_data.js')}; return PROJECT_DATA;`)();
const urls = new Set(data.map((p) => p.actionUrl).filter(Boolean));

for (const m of read('index.html').matchAll(/href="(https?:\/\/[^"]+)"/g)) {
  const u = m[1];
  if (!/fonts\.(googleapis|gstatic)\.com/.test(u)) urls.add(u);
}

const CONCURRENCY = 8;
const list = [...urls].sort();
const failures = [];

async function probe(url) {
  for (const method of ['HEAD', 'GET']) {
    try {
      const res = await fetch(url, { method, redirect: 'follow' });
      if (res.ok) return;
      // github.com answers 405 to HEAD on some paths; retry once with GET.
      if (method === 'HEAD' && (res.status === 405 || res.status === 403)) continue;
      failures.push(`${res.status} ${url}`);
      return;
    } catch (err) {
      if (method === 'GET') failures.push(`ERR ${url} (${err.message})`);
    }
  }
}

let cursor = 0;
await Promise.all(
  Array.from({ length: CONCURRENCY }, async () => {
    while (cursor < list.length) await probe(list[cursor++]);
  }),
);

console.log(`checked ${list.length} urls, ${failures.length} failed`);
if (failures.length) {
  for (const f of failures.sort()) console.error(f);
  process.exit(1);
}
