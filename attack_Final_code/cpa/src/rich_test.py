"""
Demonstrates a Rich "application" using the Layout and Live classes.

"""

from datetime import datetime

from rich import box
from rich.align import Align
from rich.console import Console, Group
from rich.layout import Layout
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, BarColumn, TextColumn
from rich.syntax import Syntax
from rich.table import Table
from rich.text import Text

console = Console()


def make_layout() -> Layout:
    """Define the layout."""
    layout = Layout(name="root")

    layout.split(
        Layout(name="header", size=3),
        Layout(name="main", ratio=1),
        Layout(name="footer", size=7),
    )
    layout["main"].split_row(
        Layout(name="side"),
        Layout(name="body", ratio=2, minimum_size=60),
    )
    layout["side"].split(Layout(name="box1"), Layout(name="box2"))
    return layout


def make_sponsor_message() -> Panel:
    """Some example content."""
    sponsor_message = Table.grid(padding=1)
    sponsor_message.add_column(style="green", justify="right")
    sponsor_message.add_column(no_wrap=True)
    sponsor_message.add_row(
        "Sponsor me",
        "[u blue link=https://github.com/sponsors/willmcgugan]https://github.com/sponsors/willmcgugan",
    )
    sponsor_message.add_row(
        "Buy me a :coffee:",
        "[u blue link=https://ko-fi.com/willmcgugan]https://ko-fi.com/willmcgugan",
    )
    sponsor_message.add_row(
        "Twitter",
        "[u blue link=https://twitter.com/willmcgugan]https://twitter.com/willmcgugan",
    )
    sponsor_message.add_row(
        "Blog", "[u blue link=https://www.willmcgugan.com]https://www.willmcgugan.com"
    )

    intro_message = Text.from_markup(
        """Consider supporting my work via Github Sponsors (ask your company / organization), or buy me a coffee to say thanks. - Will McGugan"""
    )

    message = Table.grid(padding=1)
    message.add_column()
    message.add_column(no_wrap=True)
    message.add_row(intro_message, sponsor_message)

    message_panel = Panel(
        Align.center(
            Group(intro_message, "\n", Align.center(sponsor_message)),
            vertical="middle",
        ),
        box=box.ROUNDED,
        padding=(1, 2),
        title="[b red]Thanks for trying out Rich!",
        border_style="bright_blue",
    )
    return message_panel


class Header:
    """Display header with clock."""

    def __rich__(self) -> Panel:
        grid = Table.grid(expand=True)
        grid.add_column(justify="center", ratio=1)
        grid.add_column(justify="right")
        grid.add_row(
            "[b]Rich[/b] Layout application",
            datetime.now().ctime().replace(":", "[blink]:[/]"),
        )
        return Panel(grid, style="white on blue")


def make_syntax() -> Syntax:
    code = """\
def ratio_resolve(total: int, edges: List[Edge]) -> List[int]:
    sizes = [(edge.size or None) for edge in edges]

    # While any edges haven't been calculated
    while any(size is None for size in sizes):
        # Get flexible edges and index to map these back on to sizes list
        flexible_edges = [
            (index, edge)
            for index, (size, edge) in enumerate(zip(sizes, edges))
            if size is None
        ]
        # Remaining space in total
        remaining = total - sum(size or 0 for size in sizes)
        if remaining <= 0:
            # No room for flexible edges
            sizes[:] = [(size or 0) for size in sizes]
            break
        # Calculate number of characters in a ratio portion
        portion = remaining / sum((edge.ratio or 1) for _, edge in flexible_edges)

        # If any edges will be less than their minimum, replace size with the minimum
        for index, edge in flexible_edges:
            if portion * edge.ratio <= edge.minimum_size:
                sizes[index] = edge.minimum_size
                break
        else:
            # Distribute flexible space and compensate for rounding error
            # Since edge sizes can only be integers we need to add the remainder
            # to the following line
            _modf = modf
            remainder = 0.0
            for index, edge in flexible_edges:
                remainder, size = _modf(portion * edge.ratio + remainder)
                sizes[index] = int(size)
            break
    # Sizes now contains integers only
    return cast(List[int], sizes)
    """
    syntax = Syntax(code, "python", line_numbers=True)
    return syntax


job_progress = Progress(
    "{task.description}",
    SpinnerColumn(),
    BarColumn(),
    TextColumn("[progress.percentage]{task.percentage:>3.0f}%"),
)
job_progress.add_task("[green]Cooking")
job_progress.add_task("[magenta]Baking", total=200)
job_progress.add_task("[cyan]Mixing", total=400)

total = sum(task.total for task in job_progress.tasks)
overall_progress = Progress()
overall_task = overall_progress.add_task("All Jobs", total=int(total))

progress_table = Table.grid(expand=True)
progress_table.add_row(
    Panel(
        overall_progress,
        title="Overall Progress",
        border_style="green",
        padding=(2, 2),
    ),
    Panel(job_progress, title="[b]Jobs", border_style="red", padding=(1, 2)),
)


layout = make_layout()
layout["header"].update(Header())  
layout["body"].update(make_sponsor_message())
layout["box2"].update(Panel(make_syntax(), border_style="green"))
layout["box1"].update(Panel(layout.tree, border_style="red"))
layout["footer"].update(progress_table)


from rich.live import Live
from time import sleep

with Live(layout, refresh_per_second=10, screen=True):
    while not overall_progress.finished:
        sleep(0.1)
        for job in job_progress.tasks:
            if not job.finished:
                job_progress.advance(job.id)

        completed = sum(task.completed for task in job_progress.tasks)
        overall_progress.update(overall_task, completed=completed)
    
    

# """Same as the table_movie.py but uses Live to update"""
# import time
# from contextlib import contextmanager

# from rich import box
# from rich.align import Align
# from rich.console import Console
# from rich.live import Live
# from rich.table import Table
# from rich.text import Text

# TABLE_DATA = [
#     [
#         "May 25, 1977",
#         "Star Wars Ep. [b]IV[/]: [i]A New Hope",
#         "$11,000,000",
#         "$1,554,475",
#         "$775,398,007",
#     ],
#     [
#         "May 21, 1980",
#         "Star Wars Ep. [b]V[/]: [i]The Empire Strikes Back",
#         "$23,000,000",
#         "$4,910,483",
#         "$547,969,004",
#     ],
#     [
#         "May 25, 1983",
#         "Star Wars Ep. [b]VI[/b]: [i]Return of the Jedi",
#         "$32,500,000",
#         "$23,019,618",
#         "$475,106,177",
#     ],
#     [
#         "May 19, 1999",
#         "Star Wars Ep. [b]I[/b]: [i]The phantom Menace",
#         "$115,000,000",
#         "$64,810,870",
#         "$1,027,044,677",
#     ],
#     [
#         "May 16, 2002",
#         "Star Wars Ep. [b]II[/b]: [i]Attack of the Clones",
#         "$115,000,000",
#         "$80,027,814",
#         "$656,695,615",
#     ],
#     [
#         "May 19, 2005",
#         "Star Wars Ep. [b]III[/b]: [i]Revenge of the Sith",
#         "$115,500,000",
#         "$380,270,577",
#         "$848,998,877",
#     ],
# ]

# console = Console()

# BEAT_TIME = 0.04


# @contextmanager
# def beat(length: int = 1) -> None:
#     yield
#     time.sleep(length * BEAT_TIME)


# table = Table(show_footer=False)
# table_centered = Align.center(table)

# console.clear()

# with Live(table_centered, console=console, screen=False, refresh_per_second=20):
#     with beat(10):
#         table.add_column("Release Date", no_wrap=True)

#     with beat(10):
#         table.add_column("Title", Text.from_markup("[b]Total", justify="right"))

#     with beat(10):
#         table.add_column("Budget", "[u]$412,000,000", no_wrap=True)

#     with beat(10):
#         table.add_column("Opening Weekend", "[u]$577,703,455", no_wrap=True)

#     with beat(10):
#         table.add_column("Box Office", "[u]$4,331,212,357", no_wrap=True)

#     with beat(10):
#         table.title = "Star Wars Box Office"

#     with beat(10):
#         table.title = (
#             "[not italic]:popcorn:[/] Star Wars Box Office [not italic]:popcorn:[/]"
#         )

#     with beat(10):
#         table.caption = "Made with Rich"

#     with beat(10):
#         table.caption = "Made with [b]Rich[/b]"

#     with beat(10):
#         table.caption = "Made with [b magenta not dim]Rich[/]"

#     for row in TABLE_DATA:
#         with beat(10):
#             table.add_row(*row)

#     with beat(10):
#         table.show_footer = True

#     table_width = console.measure(table).maximum

#     with beat(10):
#         table.columns[2].justify = "right"

#     with beat(10):
#         table.columns[3].justify = "right"

#     with beat(10):
#         table.columns[4].justify = "right"

#     with beat(10):
#         table.columns[2].header_style = "bold red"

#     with beat(10):
#         table.columns[3].header_style = "bold green"

#     with beat(10):
#         table.columns[4].header_style = "bold blue"

#     with beat(10):
#         table.columns[2].style = "red"

#     with beat(10):
#         table.columns[3].style = "green"

#     with beat(10):
#         table.columns[4].style = "blue"

#     with beat(10):
#         table.columns[0].style = "cyan"
#         table.columns[0].header_style = "bold cyan"

#     with beat(10):
#         table.columns[1].style = "magenta"
#         table.columns[1].header_style = "bold magenta"

#     with beat(10):
#         table.columns[2].footer_style = "bright_red"

#     with beat(10):
#         table.columns[3].footer_style = "bright_green"

#     with beat(10):
#         table.columns[4].footer_style = "bright_blue"

#     with beat(10):
#         table.row_styles = ["none", "dim"]

#     with beat(10):
#         table.border_style = "bright_yellow"

#     for box_style in [
#         box.SQUARE,
#         box.MINIMAL,
#         box.SIMPLE,
#         box.SIMPLE_HEAD,
#     ]:
#         with beat(10):
#             table.box = box_style

#     with beat(10):
#         table.pad_edge = False

#     original_width = console.measure(table).maximum

#     for width in range(original_width, console.width, 2):
#         with beat(1):
#             table.width = width

#     for width in range(console.width, original_width, -2):
#         with beat(1):
#             table.width = width

#     for width in range(original_width, 90, -2):
#         with beat(1):
#             table.width = width

#     for width in range(90, original_width + 1, 2):
#         with beat(1):
#             table.width = width

#     with beat(2):
#         table.width = None


# # import random
# # import time

# # from rich.live import Live
# # from rich.table import Table


# # def generate_table() -> Table:
# #     """Make a new table."""
# #     table = Table()
# #     table.add_column("ID")
# #     table.add_column("Value")
# #     table.add_column("Status")

# #     for row in range(random.randint(2, 6)):
# #         value = random.random() * 100
# #         table.add_row(
# #             f"{row}", f"{value:3.2f}", "[red]ERROR" if value < 50 else "[green]SUCCESS"
# #         )
# #     return table


# # with Live(generate_table(), refresh_per_second=4) as live:
# #     for _ in range(40):
# #         time.sleep(0.4)
# #         live.update(generate_table())