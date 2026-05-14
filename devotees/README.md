# Sabarimala Yatra 2026 — PWA

A Progressive Web App for the Sabarimala pilgrimage, 15–18 May 2026.

## How to publish on GitHub Pages

### Step 1 — Create the repository

1. Go to https://github.com/new (you'll need to be signed in as `tsvjqmar`)
2. Repository name: `sabarimala-yatra`
3. Visibility: **Public** (GitHub Pages requires public for free accounts)
4. Tick **"Add a README file"**
5. Click **Create repository**

### Step 2 — Upload these 6 files

1. On the new repo page, click **"Add file" → "Upload files"**
2. Drag all 6 files from the `sabarimala-pwa` folder into the upload area:
   - `index.html`
   - `manifest.json`
   - `sw.js`
   - `icon-192.png`
   - `icon-512.png`
   - `apple-touch-icon.png`
   - `favicon-32.png`
   - `README.md` (this file)
3. Scroll down, commit message: `Initial upload`
4. Click **Commit changes**

### Step 3 — Enable GitHub Pages

1. In the repo, click **Settings** (top right of the repo page)
2. Left sidebar → **Pages**
3. **Source**: Deploy from a branch
4. **Branch**: `main` → folder `/ (root)` → **Save**
5. Wait ~1–2 minutes
6. Refresh the Pages settings page. You'll see: *"Your site is live at https://tsvjqmar.github.io/sabarimala-yatra/"*

### Step 4 — Share

Share this link in WhatsApp:
```
https://tsvjqmar.github.io/sabarimala-yatra/
```

iPhone and Android users both tap it → opens in their browser → works perfectly.

## How devotees install it as an app

### iPhone (Safari)
1. Open the link in **Safari** (not Chrome — Chrome on iOS doesn't support install)
2. Tap the **Share** icon (square with up arrow) at the bottom
3. Scroll down → tap **"Add to Home Screen"**
4. Tap **Add** at the top right
5. The Ayyappa icon now sits on the home screen and opens fullscreen with no browser bar

### Android (Chrome)
1. Open the link in **Chrome**
2. Either a banner pops up asking *"Install app"*, OR
3. Tap the **⋮** menu → **"Install app"** / **"Add to Home screen"**
4. Same result — icon on home screen, opens fullscreen

## How updates work

Once installed, the app works **offline** thanks to the service worker.

When you push an update to GitHub:
1. Edit any file (e.g. `index.html`) on github.com or upload a new version
2. **Important**: edit `sw.js` and change `CACHE_VERSION = 'sabarimala-v1'` to `'sabarimala-v2'` — this tells phones to fetch the new version
3. Commit changes
4. Devotees' installed apps will auto-update on next open

## Troubleshooting

**"GitHub Pages says it's deployed but the link shows 404"**
Wait 2 more minutes — first publish can take a few minutes. Then hard-refresh (Ctrl+Shift+R / Cmd+Shift+R).

**"Can't see 'Add to Home Screen' on iPhone"**
You must use **Safari**, not Chrome or Firefox. iOS only allows PWA install from Safari.

**"My checkboxes are gone after reinstalling"**
Data is per-browser-storage on each device. To back up: use **Export JSON** (full version only) before reinstalling. Or just don't reinstall — updates are automatic.

**"The page won't load offline"**
The service worker only activates after the second visit. First time online, second time offline.

---

Swamiye Saranam Ayyappa 🙏
