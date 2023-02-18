from hashlib import md5


def mine(prefix: str) -> int:
    i = 0
    while True:
        b = f"{prefix}{i}".encode("utf-8")
        digest = md5(b).hexdigest()
        if digest[:6] == "000000":
            break

        i += 1

    return i


if __name__ == "__main__":
    prefix = "bgvyzdsv"
    result = mine(prefix)
    print(result)
