import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
	  host: "0.0.0.0",    // for 'npm run dev', exposes to all IPs
	  strictPort: true
	}
});
