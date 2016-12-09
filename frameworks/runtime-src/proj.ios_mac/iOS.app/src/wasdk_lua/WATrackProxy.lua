
WATrackProxy = {}

function WATrackProxy.initAppEventTracker()
	luaoc.callStaticMethod("WALuaTrackProxy","initAppEventTracker")
end

function WATrackProxy.autoTriggerAfterPayment(isAuto)
	luaoc.callStaticMethod("WALuaTrackProxy","autoTriggerAfterPayment")
end

function WATrackProxy.trackEvent(isAuto)
	luaoc.callStaticMethod("WALuaTrackProxy","trackEvent")
end




