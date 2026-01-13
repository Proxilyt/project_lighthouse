import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { VitePWA } from 'vite-plugin-pwa'

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      includeAssets: ['favicon.svg'],
      manifest: {
        name: 'Proxilyt',
        short_name: 'Proxilyt',
        description: 'Analyze local SEO performance for your business.',
        theme_color: '#f9fafb'
      },
    }),
  ],
})
