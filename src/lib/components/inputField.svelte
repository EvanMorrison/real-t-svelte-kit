<script lang="ts">
	export let id: string;
	export let label: string = '';
</script>

<div class="relative py-5 w-full flex">
	<input
		{id}
		{...$$restProps}
		class="
      flex-1
      peer
      border-b-2
      transition-colors
      duration-500
      placeholder:text-transparent
      placeholder:transition-colors
      placeholder:duration-300
      placeholder:placeholder-shown:focus:text-gray-500
      focus:outline-transparent
      focus:border-b-2
      focus:border-indigo-400
    "
	/>
	<label
		for={id}
		class="
      absolute
      -top-2
      left-0
      transition-all
      duration-300
      peer-focus:-top-2
      peer-placeholder-shown:top-4
    "
	>
		{label}
	</label>
</div>
