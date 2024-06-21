workspace {

    model {
        u = person "TestUser"
        ss = softwareSystem "Software System"

        u -> ss "Uses"
    }

    views {
        systemContext ss {
            include *
            autolayout lr
        }
    }

}