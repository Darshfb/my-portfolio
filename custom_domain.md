# Custom Domain Setup Guide

To give your portfolio a truly professional edge, connecting a custom domain (e.g., `www.mostafaportfolio.com`) is highly recommended.

## Step 1: Purchase a Domain
If you haven't already, purchase a domain from a registrar like:
- [Google Domains](https://domains.google/)
- [Namecheap](https://www.namecheap.com/)
- [GoDaddy](https://www.godaddy.com/)

## Step 2: Connect to Firebase Hosting
1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Select your project: **mostafaaboadscompany**.
3. In the left sidebar, go to **Build > Hosting**.
4. Click the **Add custom domain** button.
5. Enter your domain name (e.g., `mostafaportfolio.com`) and click **Continue**.

## Step 3: Verify Ownership
Firebase will provide you with a **TXT record** (e.g., `google-site-verification=...`).
1. Log in to your domain registrar's website.
2. Go to the **DNS Settings** or **DNS Management** page.
3. Add a new record of type **TXT**.
4. Set the **Host** to `@` (or leave it blank) and the **Value** to the verification string provided by Firebase.
5. Wait a few minutes and click **Verify** in the Firebase Console.

## Step 4: Add A Records
Once verified, Firebase will give you two **IP addresses** (A records).
1. In your registrar's DNS settings, add two **A records**.
2. Set the **Host** to `@`.
3. Set the **Points to** (or Value) to the first IP address.
4. Repeat for the second IP address.

## Step 5: Wait for SSL
Firebase will automatically provision an SSL certificate (HTTPS) for your domain. This can take anywhere from **1 to 24 hours**.

> [!TIP]
> Once your custom domain is live, update your **GitHub Actions** (`deploy.yml`) with the new URL in the `og:url` meta tags if necessary, although the current setup uses the `.web.app` URL which will redirect correctly.
