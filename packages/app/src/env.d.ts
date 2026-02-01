interface ImportMetaEnv {
  readonly VITE_NOVAHUB_SERVER_HOST: string
  readonly VITE_NOVAHUB_SERVER_PORT: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
