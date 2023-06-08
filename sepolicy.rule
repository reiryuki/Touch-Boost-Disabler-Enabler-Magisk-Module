# binder
magiskpolicy --live "dontaudit hal_perf_default hal_graphics_composer_default binder call"
magiskpolicy --live "allow     hal_perf_default hal_graphics_composer_default binder call"

# unix_stream_socket
magiskpolicy --live "dontaudit hal_perf_default init unix_stream_socket connectto"
magiskpolicy --live "allow     hal_perf_default init unix_stream_socket connectto"

# property_service
magiskpolicy --live "dontaudit hal_perf_default vendor_default_prop property_service set"
magiskpolicy --live "allow     hal_perf_default vendor_default_prop property_service set"

# dir
magiskpolicy --live "dontaudit vendor_hal_perf_default { hal_audio_default mtk_hal_audio audioserver } dir search"
magiskpolicy --live "allow     vendor_hal_perf_default { hal_audio_default mtk_hal_audio audioserver } dir search"


