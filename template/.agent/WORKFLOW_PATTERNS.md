# Workflow Patterns

> Reference examples for project-specific workflows. Customize and add to `.agent/workflows/` as needed.

---

## /backend — Development Server

Start your backend development server.

```markdown
---
description: start the backend development server
---

// turbo

1. Start the development server:

   \`\`\`bash

   # FastAPI example

   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

   # Django example

   # python manage.py runserver 0.0.0.0:8000

   # Express example

   # npm run dev

   \`\`\`

2. Verify by navigating to http://localhost:8000/health
```

---

## /frontend — Frontend Dev Server

Start your frontend development server.

```markdown
---
description: start the frontend development server
---

// turbo

1. Navigate to the frontend directory and start the dev server:

   \`\`\`bash
   cd frontend && npm run dev
   \`\`\`

2. Access the development server at http://localhost:3000
```

---

## /local-app — Full Local Stack

Start all local services in parallel.

```markdown
---
description: start full local application environment
---

// turbo-all

1. **Start Backend** (in background):
   \`\`\`bash
   uvicorn app.main:app --reload --port 8000 &
   \`\`\`

2. **Start Frontend** (in background):
   \`\`\`bash
   cd frontend && npm run dev &
   \`\`\`

3. **Wait for services**:
   \`\`\`bash
   sleep 5
   \`\`\`

4. **Open in browser**:
   Navigate to http://localhost:3000 using browser automation.
```

---

## /deploy — Production Deployment

Deploy to your cloud provider.

```markdown
---
description: deploy the application to production
---

1. **Pre-flight checks**:

   - Ensure all tests pass: \`pytest tests/ -m "not expensive"\`
   - Check for uncommitted changes: \`git status\`
   - Verify version bump in CHANGELOG.md

2. **Build** (if needed):
   \`\`\`bash

   # Docker build example

   docker build -t myapp:latest .
   \`\`\`

3. **Deploy**:
   \`\`\`bash

   # Cloud Run example

   gcloud run deploy myapp --source . --region us-central1

   # Vercel example

   # vercel --prod

   \`\`\`

4. **Post-deploy verification**:
   - Hit health endpoint: \`curl https://myapp.run.app/health\`
   - Run smoke tests if available
```

---

## /verify — End-to-End Verification

Run project-specific verification scripts.

```markdown
---
description: run verification scripts to test the full application
---

1. **Check for verification scripts**:
   \`\`\`bash
   ls scripts/verify\_\*.py
   \`\`\`

2. **Run API verification**:
   \`\`\`bash
   python scripts/verify_api.py
   \`\`\`

3. **Run browser verification** (if applicable):
   Use browser automation to navigate through critical user flows:

   - Login flow
   - Primary user action
   - Verify expected outcome

4. **Report results**:
   Log verification results in walkthrough.md with screenshots.
```
