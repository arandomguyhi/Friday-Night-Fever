function onCreatePost()
    callMethod('dad.setPosition', {154, 291})
    setProperty('gf.visible', false)
    setObjectOrder('dadGroup', getObjectOrder('boyfriendGroup'))
end