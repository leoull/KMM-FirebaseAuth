package comm.kmm.login

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform