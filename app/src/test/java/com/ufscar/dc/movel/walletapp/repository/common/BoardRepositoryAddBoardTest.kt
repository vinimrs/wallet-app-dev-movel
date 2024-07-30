package com.ufscar.dc.movel.walletapp.repository.common

import kotlinx.coroutines.runBlocking
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before

class BoardRepositoryAddBoardTest {

    val boardRepository = BoardRepository(true)

    @Before
    fun before() {
        runBlocking { boardRepository.reset() }
    }

    @Test
    fun `test AddBoard`() =  runBlocking {
        val newBoard = Board(
            name = "new board",
            messages = listOf()
        )
        val board = boardRepository.addBoard(newBoard)
        assertEquals("new board", board.name)
        assertEquals(3, board.id)
        assertEquals(0, board.messages.size)
    }
}