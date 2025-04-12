Excellent question — because hosting is where a lot of hidden ethical concerns live (tracking, ads, corporate ownership, etc.).
 Since you want to **avoid supporting unethical companies**, **use only free services of a provider**, and **self-host when possible**, I’ll give you a good clean table for **web app hosting** too.

I'll also give options for different levels (static sites, full web apps, and backend APIs).

------

### **Ethical Web App Hosting Options**

| Purpose                               | Provider                     | Status | Notes                                                        |
| ------------------------------------- | ---------------------------- | ------ | ------------------------------------------------------------ |
| **Static Site Hosting**               | **Netlify (Free Tier)**      | ✅      | Free tier is solid, no ads. But avoid paid tiers and upsells. |
|                                       | **Cloudflare Pages**         | ✅      | Free tier, privacy-focused, no ads. Highly recommended.      |
|                                       | **GitHub Pages**             | ⚠️      | Free, but owned by Microsoft. Use only if necessary.         |
|                                       | **Fleek (IPFS hosting)**     | ✅      | Decentralized, privacy-respecting, uses IPFS.                |
| **Dynamic Web Apps / APIs**           | **Railway (Free Tier)**      | ✅      | Free tier works, avoid paid. Not owned by Big Tech directly. |
|                                       | **Fly.io (Free Tier)**       | ✅      | Good for backend apps & APIs, free tier available.           |
|                                       | **Render (Free Tier)**       | ✅      | Free hosting for web apps and APIs. Use free tier only.      |
|                                       | **Coolify (Self-hosted)**    | ✅      | Open-source alternative to services like Heroku. Self-host for max control. |
|                                       | **CapRover (Self-hosted)**   | ✅      | Easy-to-use PaaS you can self-host. Very ethical.            |
| **Backend-Only (APIs, DBs, Workers)** | **Supabase (Free Tier)**     | ✅      | Open-source Firebase alternative. Use free tier only.        |
|                                       | **Appwrite (Self-hosted)**   | ✅      | Open-source backend-as-a-service. Fully self-hostable.       |
|                                       | **PocketBase (Self-hosted)** | ✅      | Lightweight backend you can host yourself. Good for small apps. |
| **Databases**                         | **Postgres (Self-hosted)**   | ✅      | Open-source and free to self-host. Very stable.              |
|                                       | **SQLite (Embedded)**        | ✅      | Lightweight embedded database, no external host needed.      |
|                                       | **MariaDB (Self-hosted)**    | ✅      | Open-source fork of MySQL, free and ethical.                 |
| **Domain & DNS**                      | **Njalla**                   | ✅      | Privacy-first registrar and DNS provider.                    |
|                                       | **Cloudflare DNS**           | ✅      | Free, fast, privacy-focused DNS. Use free tier only.         |

------

### Notes:

- ✅ **Highly recommended**
- ⚠️ **Acceptable only if you have no better choice**
- ❌ **Avoid** (not listed in table to keep it clean — like AWS, Azure, Google Cloud)

### If you want **maximum ethics and control**, I strongly recommend:

- **Self-hosting** on ethical VPS providers like **Hetzner**, **Contabo**, or **Scaleway** (make sure to review their ethical standings yourself).
- Use **Cloudflare Pages** for frontend static hosting.
- Pair it with **CapRover** or **Coolify** for backend apps.
- Use **Postgres** or **SQLite** for databases.

------

### Suggested Ethical Stack for a Web App:

- **Frontend**: Static assets on **Cloudflare Pages**
- **Backend**: API on **Fly.io** or **Coolify**
- **Database**: **Postgres** (self-hosted) or **SQLite**
- **Domain & DNS**: **Njalla** or **Cloudflare DNS**

------

If you tell me the exact type of app you’re building (for example: real-time app, e-commerce, multiplayer game dashboard, etc.), I can give you an even **more specific recommendation** that fits your needs and ethics 100%. 🚀

Would you like me to build a **full stack setup** for you as well? (frontend, backend, DB, CI/CD, hosting — all ethical 🌱)