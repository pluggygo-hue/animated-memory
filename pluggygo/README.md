# PluggyGo

EV charging discovery and management platform starter monorepo.

## Included
- `mobile/`: Flutter customer app starter (station discovery dashboard with demo data)
- `admin/`: Next.js admin dashboard starter
- `super-admin/`: Next.js super-admin dashboard starter
- `backend/`: Express API starter with health, stations, and dashboard endpoints
- `.github/workflows/android-apk.yml`: GitHub Actions Android APK build workflow

## Prerequisites
- Flutter stable + Android SDK
- Node.js 20+
- npm

## Run the backend
```bash
cd backend
npm install
npm run dev
```
API: http://localhost:4000/api/health

## Run the admin dashboards
In either `admin` or `super-admin`:
```bash
npm install
npm run dev
```
Admin defaults to http://localhost:3000; super-admin can use another port:
```bash
npm run dev -- --port 3001
```

## Run the Flutter app
```bash
cd mobile
flutter create . --platforms=android,ios --org com.pluggygo
flutter pub get
flutter run
```

## Build APK locally
```bash
cd mobile
flutter build apk --release
```

## GitHub Actions
Push this repository to GitHub. The workflow builds a release APK on pushes to `main` and on manual dispatch. Download it from the workflow run's Artifacts section.

## Important production work still required
This is a starter/MVP foundation, not a live charging network. Before public launch:
1. Connect CPO/OCPP or partner APIs and validate station/connector status.
2. Add authentication, role-based access control, and secure secrets management.
3. Integrate a payment gateway and verify settlement/refund flows.
4. Add database migrations, audit logging, monitoring, backups, and tests.
5. Complete privacy policy, terms, security review, and Play Store/App Store compliance.

Never put API keys, payment secrets, or production credentials in source code.
