import { MetaProvider, Title, Meta } from "@solidjs/meta"
import { Router } from "@solidjs/router"
import { FileRoutes } from "@solidjs/start/router"
import { Suspense } from "solid-js"
import { Favicon } from "@novahub/ui/favicon"
import { Font } from "@novahub/ui/font"
import "@ibm/plex/css/ibm-plex.css"
import "./app.css"

export default function App() {
  return (
    <Router
      explicitLinks={true}
      root={(props) => (
        <MetaProvider>
          <Title>novahub</Title>
          <Meta name="description" content="NovaHub - The open source coding agent." />
          <Favicon />
          <Font />
          <Suspense>{props.children}</Suspense>
        </MetaProvider>
      )}
    >
      <FileRoutes />
    </Router>
  )
}
