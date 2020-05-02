use v6;

module Util::Uuencode {

    multi sub uuencode(Str $in --> buf8) is export(:DEFAULT) {
        uuencode(buf8.new($in.encode));
    }

    multi sub uuencode(buf8 $in is copy --> buf8) is export(:DEFAULT) {
        my $elems = $in.elems;
        my  buf8 $out = buf8.new;

        my Int $pos = 0;

        while ( $pos < $elems ) {
            my $buf = $in.subbuf($pos, 45);

            my Int @line;
            @line.append: $buf.elems + 32;

            $buf.append: (0) xx (3 - ($elems % 3));

            for (^(($buf.elems * 8) / 6 )).map( * * 6 ) -> $start {
                @line.append: $buf.read-ubits($start, 6) + 32;
            }
            @line.append: "\n".ord;
            $out.append: @line;
            $pos += 45;
        }
        $out;
    }

    multi sub uudecode(Str $in --> buf8) is export(:DEFAULT) {
        my buf8 $out = buf8.new;

        for $in.lines.map( -> $v { buf8.new($v.encode.list) } ) -> $line {
            my Int $out-chars = $line.shift - 32;
            my $pos = 0;
            my buf8 $out-line = buf8.new;
            for $line.list.map( * - 32 ) -> $char {
                $out-line.write-bits($pos, 6, $char);
                $pos += 6;
            }
            $out.append: $out-line.subbuf(0, $out-chars);
        }
        $out;
    }


}

# vim: ft=raku
