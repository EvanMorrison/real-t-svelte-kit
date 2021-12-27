<script lang="ts" context="module">
	export async function load({ session }) {
		if (!session?.user) {
			return {
				status: 302,
				redirect: '/'
			};
		}

		return {
			props: {
				currentUser: session.user
			}
		};
	}
</script>

<script lang="ts">
	import { setContext } from 'svelte';

	export let currentUser: CurrentUser;

	setContext('currentUser', currentUser);
</script>

<slot />
