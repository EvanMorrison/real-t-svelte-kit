<script>
	import Header from '$lib/pageComponents/authPageHeader.svelte';

	fetch('/logout.json');
</script>

<Header />
<h1 class="text-center font-thin text-4xl my-12">You have logged out.</h1>
<div class="flex justify-center my-6">
	<div class="flex-1 max-w-md text-center text-sm">
		Log back in. <a href="/login"
			><span class="material-icons-round align-middle ml-2 mr-1">login</span>
			Login</a
		>.
	</div>
</div>
