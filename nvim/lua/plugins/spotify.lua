return {
	"iamt4nk/smm.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = {
		premium = true,
		icons = true,
		playback = {
			timer_update_interval = 250,
			timer_sync_interval = 5000,
			playback_pos = "TopRight",
			playback_width = 30,
			progress_bar_width = 25,
			song_links = false,
		},
		spotify = {
			api_retry_max = 3,
			api_retry_backoff = 2000,
			auth = {
				client_id = vim.env.SPOTIFY_CLIENT_ID,
				callback_url = "http://127.0.0.1",
				callback_port = "8000",
			},
		},
	},
}
