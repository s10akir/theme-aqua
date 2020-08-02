# name: ocean
# A fish theme with ocean in mind.


## Set this options in your config.fish (if you want to)
# set -g theme_display_user yes
# set -g default_user default_username

set __oceanfish_glyph_anchor \u2693
set __oceanfish_glyph_flag \u2691
set __oceanfish_glyph_radioactive \u2622

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end


function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end


function fish_prompt
    set -l last_status $status

    set -l black   (set_color black)
    set -l blue    (set_color blue)
    set -l cyan    (set_color cyan)
    set -l green   (set_color green)
    set -l magenta (set_color magenta)
    set -l red     (set_color red)
    set -l white   (set_color white)
    set -l yellow  (set_color yellow)

    set -l brblack   (set_color brblack)
    set -l brblue    (set_color brblue)
    set -l brcyan    (set_color brcyan)
    set -l brgreen   (set_color brgreen)
    set -l brmagenta (set_color brmagenta)
    set -l brred     (set_color brred)
    set -l brwhite   (set_color brwhite)
    set -l bryellow  (set_color bryellow)

    set -l bg_black   (set_color -b black)
    set -l bg_blue    (set_color -b blue)
    set -l bg_cyan    (set_color -b cyan)
    set -l bg_green   (set_color -b green)
    set -l bg_magenta (set_color -b magenta)
    set -l bg_red     (set_color -b red)
    set -l bg_white   (set_color -b white)
    set -l bg_yellow  (set_color -b yellow)

    set -l bg_brblack   (set_color -b brblack)
    set -l bg_brblue    (set_color -b brblue)
    set -l bg_brcyan    (set_color -b brcyan)
    set -l bg_brgreen   (set_color -b brgreen)
    set -l bg_brmagenta (set_color -b brmagenta)
    set -l bg_brred     (set_color -b brred)
    set -l bg_brwhite   (set_color -b brwhite)
    set -l bg_bryellow  (set_color -b bryellow)

    set -l normal (set_color normal)
    set -l cwd $white(prompt_pwd)
    set -l uid (id -u $USER)


    # Show a yellow radioactive symbol for root privileges
    if [ $uid -eq 0 ]
        echo -n -s $bg_yellow $black " $__oceanfish_glyph_radioactive " $normal
    end


    # Display virtualenv name if in a virtualenv
    if set -q VIRTUAL_ENV
        echo -n -s $bg_cyan $black " " (basename "$VIRTUAL_ENV") " " $normal
    end


    # Show a nice anchor (turns red if previous command failed)
    if test $last_status -ne 0
        echo -n -s $bg_brmagenta $red " $__oceanfish_glyph_anchor "  $normal
    else
        echo -n -s $bg_brmagenta $brcyan " $__oceanfish_glyph_anchor " $normal
    end


    # Display username@hostname
    echo -n -s $bg_white $cyan " " (whoami) "@" (hostname -s) " " $normal


    # Display current path
    echo -n -s $bg_brmagenta " $cwd " $normal


    # Show git branch and dirty state
    if [ (_git_branch_name) ]
        set -l git_branch (_git_branch_name)
        if [ (_is_git_dirty) ]
            echo -n -s $bg_white $brmagenta " $git_branch " $red "$__oceanfish_glyph_flag " $normal
        else
            echo -n -s $bg_white $brmagenta " $git_branch " $normal
        end
    end


    # Terminate with a space
    echo -n -s ' ' $normal
end
