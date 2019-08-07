meta:
    id: cpio_portable_ascii
    endian: be
seq:
    - id: entries
      type: cpio_portable_ascii_header_and_file
      repeat: until
      repeat-until: _.filename == "TRAILER!!!"
types:
    cpio_portable_ascii_header_and_file:
        seq:
            - id: header
              type: cpio_portable_ascii_header
            - id: filename
              type: str
              encoding: ascii
              size: header.namesize.to_i(8)
              terminator: 0
              # Unlike the old binary format, there is no additional padding after the pathname or file contents.
            - id: filedata
              size: header.filesize.to_i(8)
    cpio_portable_ascii_header:
      seq:
            - id: magic
              contents: "070707"
            - id: dev
              type: str
              size: 6
              encoding: ascii
            - id: ino
              type: str
              size: 6
              encoding: ascii
            - id: mode
              type: str
              size: 6
              encoding: ascii
            - id: uid
              type: str
              size: 6
              encoding: ascii
            - id: gid
              type: str
              size: 6
              encoding: ascii
            - id: nlink
              type: str
              size: 6
              encoding: ascii
            - id: rdev
              type: str
              size: 6
              encoding: ascii
            - id: mtime
              type: str
              size: 11
              encoding: ascii
            - id: namesize
              type: str
              size: 6
              encoding: ascii
            - id: filesize
              type: str
              size: 11
              encoding: ascii
