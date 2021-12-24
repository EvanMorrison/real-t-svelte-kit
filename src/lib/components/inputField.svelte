<script lang="ts">
	export let id: string;
	export let label = '';
	export let error = '';
	export let helperText = '';
	export let required = false;
	export let value = '';
</script>

<div class="relative py-2 w-full flex flex-col">
	<div
		class="
      relative
      border-2
      border-indigo-500
      rounded-lg
      p-2
      flex
      flex-1
    "
		class:error
	>
		<input
			on:focus
			on:blur
			on:input
			bind:value
			{id}
			{required}
			{...$$restProps}
			class="
          flex-1
          peer
          placeholder:text-transparent
          placeholder:transition-colors
          placeholder:duration-300
          placeholder:placeholder-shown:focus:text-gray-500
          focus:outline-transparent
        "
			class:error
		/>
		<label
			for={id}
			class="
          absolute
          -top-2.5
          left-2
          bg-white
          px-1
          text-xs
          transition-all
          duration-300
          peer-focus:-top-2.5
          peer-placeholder-shown:top-2
          peer-placeholder-shown:text-base
          peer-focus:text-xs
          peer-required:after:content-['*']
          peer-required:after:text-red-600
          peer-required:after:font-bold
          peer-required:after:ml-0.5
        "
		>
			{label}
		</label>
	</div>
	{#if !error}
		<div class="text-xs pl-3 pt-1 min-h-[1.5rem]">
			{#if helperText}
				<span>{helperText}</span>
			{/if}
		</div>
	{:else}
		<div class="text-xs pl-3 pt-1 min-h-[1.5rem] text-red-600">{error}</div>
	{/if}
</div>

<style>
	div.error {
		@apply border-red-600;
	}

	input.error {
		@apply text-red-600;
	}
</style>
