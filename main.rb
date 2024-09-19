require 'glimmer-dsl-libui'

class Password

    include Glimmer

    attr_accessor :pass

    def change_letters(text_pass)

        new_text = ""
        letters = text_pass.split('')

        for i in (0..text_pass.length - 1) do

            letter = letters[i].to_s.downcase

            if letter == "a"

                possible_lttrs = [4, "a", "A", "@", "/-\\", "あ"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            elsif letter == "e"
                
                possible_lttrs = [3, "e", "E", "&", "え"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            elsif letter == "o"
                
                possible_lttrs = [0, "o", "O", "お"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            elsif letter == "i"
                
                possible_lttrs = [1, "i", "I", "|", "い"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s
            
            elsif letter == "u"
                
                possible_lttrs = ["u", "U", "う"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            elsif letter == "s"
                
                possible_lttrs = ["s", "S", "$"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            elsif letter == "c"
                
                possible_lttrs = ["c", "C", "ç", "Ç"]
                choice = Random.rand(0..possible_lttrs.length-1)

                letter = possible_lttrs[choice].to_s

            else
                choice = Random.rand(0..1)
                if choice == 0
                    letter = letter.downcase
                else
                    letter = letter.upcase
                end

            end

            new_text = new_text + letter

        end

        return new_text

    end


    def initialize
        pass = ""
    end

    def app
        mods = ''
        window("Super password", 300, 150) {
            margined true

            
            vertical_box{

                label {
                    stretchy false
                    text 'Make your password stronger'
                }

                form {
                    stretchy false

                    @password = entry{
                        label 'Password: '
                        text 'Password_1234'
                    }

                    @final = entry{
                        label 'New Password:'
                        text <= [self, :pass, on_read: -> (pass) {"#{pass}"}]
                    }
                }

                button('Generate new password') {
                    stretchy false

                    on_clicked do
                        mods = ''
                        specialChars = ['#', '$', '-', '~', '_', '%', '|', '\\', '/', '*', '+']
                        
                        new_pass = @password.text

                        if new_pass.length < 8
                            while new_pass.length < 8
                                new_pass = new_pass + specialChars.shuffle[0]
                            end
                            mods = mods + "Added more characters \n"
                        end

                        choice = Random.rand(0..2)

                        if choice == 1
                            if new_pass.length < 10
                                new_pass = specialChars.shuffle[0] + new_pass + specialChars.shuffle[0]
                                mods = mods + "Increased to 10 characters! \n"
                            end
                        end

                        new_pass = change_letters new_pass
                        mods = mods + "Changed some characters (Ex: A -> 4; E -> 3; S -> $) \n"

                        choice = Random.rand(0..10)
                        case choice
                        when 0
                            new_pass = new_pass.reverse
                            mods = mods + "Reversed \n"
                        when 1
                            new_pass = "#" + new_pass
                            mods = mods + "Added # \n"
                        when 2
                            new_pass = "#" + new_pass.reverse
                            mods = mods + "Reversed \n"
                            mods = mods + "Added # \n"
                        when 3
                            new_pass = new_pass + specialChars.shuffle[0]
                            mods = mods + "Added one more special character \n"
                        when 4
                            new_pass = new_pass + "-" + Random.rand(33..126).chr
                            mods = mods + "Added one more random character (after -) \n"
                        when 5
                            new_pass = "Do_" + new_pass + "_?"
                            mods = mods + "Your password now is a question! \n"
                        when 6
                            new_pass = "Do_" + new_pass.reverse + "_?"
                            mods = mods + "Reversed \n"
                            mods = mods + "Your password now is a question! \n"
                        when 7
                            new_pass = new_pass + new_pass
                            mods = mods + "Duplicated \n"
                        when 8
                            new_pass = new_pass + new_pass.reverse
                            mods = mods + "Duplicated reversed \n"
                        when 9
                            new_pass = Random.rand(33..126).chr + "-" + new_pass + "-" + Random.rand(33..126).chr
                            mods = mods + "Added two more random characters (after/before -) \n"
                        when 10
                            new_pass = new_pass + "|Ruby|"
                            mods = mods + "Added Ruby \n"
                        end

                        self.pass = new_pass
                        #msg_box('-=Changes=-', mods)

                    end
                }

                button('What changed?'){
                    on_clicked do
                        msg_box('-=Changes=-', mods)
                    end
                }
            }
        }.show
    end
end

Password.new.app