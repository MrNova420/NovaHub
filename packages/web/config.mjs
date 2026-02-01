const stage = process.env.SST_STAGE || "dev"

export default {
  url: stage === "production" ? "https://novahub.ai" : `https://${stage}.novahub.ai`,
  console: stage === "production" ? "https://novahub.ai/auth" : `https://${stage}.novahub.ai/auth`,
  email: "contact@anoma.ly",
  socialCard: "https://social-cards.sst.dev",
  github: "https://github.com/anomalyco/novahub",
  discord: "https://novahub.ai/discord",
  headerLinks: [
    { name: "Home", url: "/" },
    { name: "Docs", url: "/docs/" },
  ],
}
