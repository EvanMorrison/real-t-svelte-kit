<script lang="ts" context="module">
	import type { Load, Page } from '@sveltejs/kit';

	export const load: Load = ({ page }) => {
		console.log('page', page);
		return {
			props: {
				page
			}
		};
	};
</script>

<script lang="ts">
	import '../app.css';

	export let page: Page;
</script>

<slot {page} />
