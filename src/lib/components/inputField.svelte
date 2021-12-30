<script lang="ts">
	export let id: string;
	export let name = '';
	export let label = '';
	export let error = '';
	export let helperText = '';
	export let required = false;
	export let value = '';
	export let textarea = false;
	export let placeholder = ' ';
	export let bg = 'bg-white';

	$: name = id;
</script>

<div class="relative py-1 w-full flex flex-col">
	<div
		class={`
      relative
      p-1.5
      pb-0
			border-b-2
      flex
      flex-1
			after:absolute
			after:border-b-2
			after:border-indigo-500
			after:-bottom-[2px]
			after:left-0
			after:h-2
			after:w-full
			after:scale-x-0
			after:transition-transform
			after:duration-200
			focus-within:after:scale-x-100
			${bg}
    `}
		class:error
	>
		{#if textarea}
			<textarea
				on:focus
				on:blur
				on:input
				bind:value
				{id}
				{name}
				{required}
				{placeholder}
				{...$$restProps}
				class={`
					flex-1
					max-w-full
					max-h-full
					peer
					placeholder:text-transparent
          placeholder:transition-colors
          placeholder:duration-300
          placeholder:placeholder-shown:focus:text-gray-500
          focus:outline-none
					${bg}
				`}
			/>
		{:else}
			<input
				on:focus
				on:blur
				on:input
				bind:value
				{id}
				{name}
				{required}
				{placeholder}
				{...$$restProps}
				class={`
          flex-1
					max-w-full
          peer
          placeholder:text-transparent
          placeholder:transition-colors
          placeholder:duration-300
          placeholder:placeholder-shown:focus:text-gray-500
          focus:outline-transparent
					focus-visible:outline-none
					${bg}
        `}
				class:error
			/>
		{/if}
		<label
			for={id}
			class={`
          absolute
          -top-2.5
          left-2
          px-1
          text-xs
          transition-all
          duration-300
          peer-focus:-top-2.5
          peer-placeholder-shown:top-1.5
          peer-placeholder-shown:text-base
          peer-focus:text-xs
          peer-required:after:content-['*']
          peer-required:after:text-red-600
          peer-required:after:font-bold
          peer-required:after:ml-0.5
					rounded-md
					${bg}
        `}
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
