/**
 * Application-wide constants and configuration
 */
export const config = {
  // Base URL
  baseUrl: "https://novahub.ai",

  // GitHub
  github: {
    repoUrl: "https://github.com/anomalyco/novahub",
    starsFormatted: {
      compact: "80K",
      full: "80,000",
    },
  },

  // Social links
  social: {
    twitter: "https://x.com/novahub",
    discord: "https://discord.gg/novahub",
  },

  // Static stats (used on landing page)
  stats: {
    contributors: "600",
    commits: "7,500",
    monthlyUsers: "1.5M",
  },
} as const
